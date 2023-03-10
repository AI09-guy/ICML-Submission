import argparse
import os
import sys

import pandas as pd

import Completeness_and_interventions.completeness_utils as cci_utils

sys.path.append(os.path.abspath("root-path"))


def config():
    parser = argparse.ArgumentParser(description='Get important concepts masks')
    parser.add_argument('--base_path', metavar='DIR',
                        default='root-path',
                        help='path to checkpoints')
    parser.add_argument('--checkpoints', metavar='DIR',
                        default='root-path/checkpoints',
                        help='path to checkpoints')
    parser.add_argument('--output', metavar='DIR',
                        default='root-path/out',
                        help='path to output logs')
    parser.add_argument('--logs', metavar='DIR',
                        default='root-path/log',
                        help='path to tensorboard logs')
    parser.add_argument('--bs', '--batch-size', default=16, type=int, metavar='N', help='batch size BB')
    parser.add_argument('--flattening-type', type=str, default="adaptive", help='flatten or adaptive or maxpool')
    parser.add_argument('--seed', type=int, default=0, help='seed')
    parser.add_argument('--epochs', type=int, default=50, help='epochs')

    parser.add_argument('--dataset', type=str, default="cub", help='dataset name')
    parser.add_argument('--arch', type=str, default="ResNet101", help='Arch')
    parser.add_argument('--iterations', type=int, default="6", help='iteration')
    parser.add_argument('--top_K', nargs='+', default=[3, 5, 10, 15, 20, 25, 30], type=int, help='How many concepts?')
    parser.add_argument('--model', default='MoIE', type=str, help='MoIE or Baseline_CBM_logic or Baseline_PCBM_logic')

    return parser.parse_args()


def compute_completeness_score(args, model_type):
    print(f"TopK: {args.topK}")
    args.json_file = os.path.join(args.base_path, "codebase", "Completeness_and_interventions", "paths_MoIE.json")
    args.per_iter_completeness = True
    cci_utils.set_seeds(args)
    (
        train_loader, val_loader, g_chk_pt_path, g_output_path, g_tb_logs_path, results_path
    ) = cci_utils.get_initial_setups(args, model_type)

    g_completeness, classifier, cav, device = cci_utils.setup_pretrained_models(args)
    g_completeness = cci_utils.train_g_for_completeness_score(
        args, g_completeness, classifier, cav, g_chk_pt_path, g_tb_logs_path, g_output_path,
        train_loader, val_loader, device
    )
    result_dict = cci_utils.compute_completeness_score(
        args, g_completeness, classifier, cav, g_output_path, val_loader, device
    )

    return result_dict, results_path


def main():
    args = config()
    print(f"Concept completeness: {args.dataset}")
    results_arr = []
    for top_k in args.top_K:
        args.topK = top_k
        if args.model == "MoIE":
            result_dict, results_path = compute_completeness_score(args, model_type="moIE")
        elif args.model == "Baseline_PCBM_logic":
            result_dict, results_path = compute_completeness_score(args, model_type="Baseline_PostHoc")

        results_arr.append(result_dict)

    df = pd.DataFrame(results_arr)
    df.to_csv(os.path.join(results_path, f"Completeness_score_epochs_{args.epochs}.csv"))
    print(results_path)
    print(df)


if __name__ == '__main__':
    main()
