import argparse
import os
import sys

from Explainer.experiments_explainer_CUB import train_baseline_post_hoc, test_baseline_post_hoc
from Explainer.experiments_explainer_awa2 import train_glt

sys.path.append(os.path.abspath("/ocean/projects/asc170022p/shg121/PhD/ICLR-2022"))

parser = argparse.ArgumentParser(description='AWA2 Training')
parser.add_argument('--data-root', metavar='DIR',
                    default='/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/data/awa2',
                    help='path to dataset')
parser.add_argument('--logs', metavar='DIR',
                    default='/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/log',
                    help='path to tensorboard logs')
parser.add_argument('--checkpoints', metavar='DIR',
                    default='/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints',
                    help='path to checkpoints')
parser.add_argument('--checkpoint-model', metavar='file', nargs="+",
                    default=['model_g_best_model_epoch_116.pth.tar'],
                    help='checkpoint file of the model GatedLogicNet')
parser.add_argument('--checkpoint-residual', metavar='file', nargs="+",
                    default=['model_residual_best_model_epoch_2.pth.tar'],
                    help='checkpoint file of residual')
parser.add_argument('--root-bb', metavar='file',
                    default='lr_0.001_epochs_95',
                    help='checkpoint folder of BB')
parser.add_argument('--checkpoint-bb', metavar='file',
                    default='best_model_epoch_63.pth.tar',
                    help='checkpoint file of BB')
parser.add_argument('--checkpoint-t', metavar='file',
                    default='g_best_model_epoch_200.pth.tar',
                    help='checkpoint file of t')
parser.add_argument('--output', metavar='DIR',
                    default='/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/out',
                    help='path to output logs')
parser.add_argument('--attribute-file-name', metavar='file',
                    default='attributes.npy',
                    help='file containing all the concept attributes')
parser.add_argument('--iter', default=2, type=int, metavar='N', help='iteration')
parser.add_argument('--expert-to-train', default="explainer", type=str, metavar='N',
                    help='which expert to train? explainer or residual')
parser.add_argument('--seed', default=1, type=int, metavar='N', help='seed')
parser.add_argument('--pretrained', type=bool, default=True, help='pretrained imagenet')
parser.add_argument('--dataset', type=str, default="awa2", help='dataset name')
parser.add_argument('--img-size', type=int, default=448, help='image\'s size for transforms')
parser.add_argument('--cov', nargs='+', default=[0.45, 0.4], type=float, help='coverage of the dataset')
parser.add_argument('--alpha', default=0.5, type=float, help='trade off for Aux explainer using Selection Net')
parser.add_argument('--selection-threshold', default=0.5, type=float,
                    help='selection threshold of the selector for the test/val set')
parser.add_argument('--use-concepts-as-pi-input', default="y", type=str,
                    help='Input for the pi - Concepts or features? y for concepts else features')
parser.add_argument('--bs', '--batch-size', default=16, type=int, metavar='N', help='batch size BB')
parser.add_argument('--dataset-folder-concepts', type=str,
                    default="lr_0.001_epochs_95_ResNet101_layer4_adaptive_sgd_BCE",
                    help='dataset folder of concepts')
parser.add_argument('--lr-residual', '--learning-rate-residual', default=0.001, type=float,
                    metavar='LR', help='initial learning rate of bb residual')
parser.add_argument('--momentum-residual', type=float, default=0.9, help='momentum for SGD')
parser.add_argument('--weight-decay-residual', type=float, default=1e-4, help='weight_decay for SGD')
parser.add_argument('--lr', '--learning-rate', nargs='+', default=[0.01, 0.001], type=float,
                    metavar='LR', help='initial learning rate')
parser.add_argument('--input-size-pi', default=2048, type=int,
                    help='input size of pi - 2048 for layer4 (ResNet) or 1024 for layer3 (ResNet) ')
parser.add_argument('--temperature-lens', default=0.7, type=float, help='temperature for entropy layer in lens')
parser.add_argument('--lambda-lens', default=0.0001, type=float, help='weight for entropy loss')
parser.add_argument('--alpha-KD', default=0.9, type=float, help='weight for KD loss by Hinton')
parser.add_argument('--temperature-KD', default=10, type=float, help='temperature for KD loss')
parser.add_argument('--conceptizator', default='identity_bool', type=str, help='activation')
parser.add_argument('--hidden-nodes', nargs="+", default=[10], type=int, help='hidden nodes of the explainer model')
parser.add_argument('--explainer-init', default=None, type=str, help='Initialization of explainer')
parser.add_argument('--epochs', type=int, default=500, help='batch size for training the explainer - g')
parser.add_argument('--epochs-residual', type=int, default=50, help='batch size for training the residual')
parser.add_argument('--layer', type=str, default="layer4", help='batch size for training of t')
parser.add_argument('--arch', type=str, default="ResNet101", required=True, help='ResNet50 or ResNet101 or ResNet152')
parser.add_argument('--smoothing_value', type=float, default=0.0,
                    help="Label smoothing value\n")
parser.add_argument("--decay_type", choices=["cosine", "linear"], default="cosine",
                    help="How to decay the learning rate.")
parser.add_argument("--warmup_steps", default=500, type=int,
                    help="Step of training to perform learning rate warmup for.")
parser.add_argument("--max_grad_norm", default=1.0, type=float,
                    help="Max gradient norm.")
parser.add_argument("--weight_decay", default=0, type=float,
                    help="Weight deay if we apply some.")
parser.add_argument("--num_steps", default=10000, type=int,
                    help="Total number of training epochs to perform.")
parser.add_argument('--prev_explainer_chk_pt_folder', metavar='path', nargs="+",
                    default=[
                        "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/cub/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1",
                    ],
                    help='checkpoint file of residual')

parser.add_argument('--train_baseline', type=str, default="n", help='train baseline or glt')

parser.add_argument('--concept-names', nargs='+',
                    default=["black",
                             "white", "blue", "brown", "gray", "orange", "red", "yellow", "patches", "spots", "stripes",
                             "furry", "hairless", "toughskin", "big", "small", "bulbous", "lean", "flippers", "hands",
                             "hooves", "pads", "paws", "longleg", "longneck", "tail", "chewteeth", "meatteeth",
                             "buckteeth", "strainteeth", "horns", "claws", "tusks", "smelly", "flys", "hops", "swims",
                             "tunnels", "walks", "fast", "slow", "strong", "weak", "muscle", "bipedal", "quadrapedal",
                             "active", "inactive", "nocturnal", "hibernate", "agility", "fish", "meat", "plankton",
                             "vegetation", "insects", "forager", "grazer", "hunter", "scavenger", "skimmer", "stalker",
                             "newworld", "oldworld", "arctic", "coastal", "desert", "bush", "plains", "forest",
                             "fields", "jungle", "mountains", "ocean", "ground", "water", "tree", "cave", "fierce",
                             "timid", "smart", "group", "solitary", "nestspot", "domestic",
                             ])
parser.add_argument('--labels', nargs='+',
                    default=[
                        "antelope", "grizzly+bear", "killer+whale", "beaver", "dalmatian", "persian+cat", "horse",
                        "german+shepherd", "blue+whale", "siamese+cat", "skunk", "mole", "tiger", "hippopotamus",
                        "leopard", "moose", "spider+monkey", "humpback+whale", "elephant", "gorilla", "ox",
                        "fox", "sheep", "seal", "chimpanzee", "hamster", "squirrel", "rhinoceros", "rabbit", "bat",
                        "giraffe", "wolf", "chihuahua", "rat", "weasel", "otter", "buffalo", "zebra", "giant+panda",
                        "deer", "bobcat", "pig", "lion", "mouse", "polar+bear", "collie",
                        "walrus", "raccoon", "cow", "dolphin"
                    ])

parser.add_argument('--projected', type=str, default="n", required=False, help='n')
parser.add_argument('--soft', default='y', type=str, metavar='N', help='soft/hard concept?')
parser.add_argument('--with_seed', default='n', type=str, metavar='N', help='trying diff seeds for paper')
parser.add_argument('--logistic_explainer', default='n', type=str, metavar='N', help='Logistic/Elens explainer')
parser.add_argument('--test_baseline', default='n', type=str, metavar='N', help='tran/test baseline')
parser.add_argument('--g_checkpoint', metavar='file',
                    default='best_model_epoch_63.pth.tar',
                    help='baseline chkpt')

parser.add_argument('--profile', metavar='str', default='n', help='baseline chkpt')


def main():
    args = parser.parse_args()
    print("Inputs")
    # train_glt(args)
    # if args.train_baseline == "y":
    #     print("Training baseline for CUB")
    #     for arg in vars(args):
    #         print(f"{arg}: {getattr(args, arg)}")
    #     train_baseline_post_hoc(args)
    for arg in vars(args):
        print(f"{arg}: {getattr(args, arg)}")
    if args.train_baseline == "y":
        print("Training baseline for Awa2")
        train_baseline_post_hoc(args)
    elif args.test_baseline == "y":
        print("Testing baseline for CUB")
        for arg in vars(args):
            print(f"{arg}: {getattr(args, arg)}")
        test_baseline_post_hoc(args)
    else:
        print("Training explainer for AWA2")
        train_glt(args)


if __name__ == '__main__':
    main()
