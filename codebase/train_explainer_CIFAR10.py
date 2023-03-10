import argparse
import os
import sys

from Explainer.experiments_explainer_cifar10 import test, train

sys.path.append(os.path.abspath("root-path"))

parser = argparse.ArgumentParser(description='CUB Training')
parser.add_argument('--data-root', metavar='DIR',
                    default='root-path/data/CIFAR100',
                    help='path to dataset')
parser.add_argument('--logs', metavar='DIR',
                    default='root-path/log',
                    help='path to tensorboard logs')
parser.add_argument('--checkpoints', metavar='DIR',
                    default='root-path/checkpoints',
                    help='path to checkpoints')
parser.add_argument('--output', metavar='DIR',
                    default='root-path/out',
                    help='path to output logs')
parser.add_argument('--seed', default=0, type=int, metavar='N', help='seed')
parser.add_argument('--pretrained', type=bool, default=True, help='pretrained imagenet')
parser.add_argument('--dataset', type=str, default="CIFAR100", help='dataset name')
parser.add_argument('--img-size', type=int, default=448, help='image\'s size for transforms')
parser.add_argument(
    '--bs', '--batch-size', '--train_batch_size', '--eval_batch_size', default=100, type=int,
    metavar='N', help='batch size BB'
)

parser.add_argument('--num-workers', default=4, type=int, metavar='N',
                    help='number of data loading workers (default: 4)')
parser.add_argument("--eval_every", default=100, type=int,
                    help="100Run prediction on validation set every so many steps."
                         "Will always run one evaluation at the end of training.")
parser.add_argument('--arch', type=str, default="ResNet50", help='Architecture of BB')
parser.add_argument("--name", default="VIT_CUBS",
                    help="Name of this run. Used for monitoring.")
parser.add_argument(
    "--pretrained_dir", type=str,
    default="root-path/checkpoints/pretrained_VIT/ViT-B_16.npz",
    help="Where to search for pretrained ViT models."
)
parser.add_argument("--pretrained_model", type=str, default=None,
                    help="load pretrained model")
parser.add_argument("--num_steps", default=10000, type=int,
                    help="Total number of training epochs to perform.")
parser.add_argument("--decay_type", choices=["cosine", "linear"], default="cosine",
                    help="How to decay the learning rate.")
parser.add_argument("--warmup_steps", default=500, type=int,
                    help="Step of training to perform learning rate warmup for.")
parser.add_argument("--max_grad_norm", default=1.0, type=float,
                    help="Max gradient norm.")
parser.add_argument("--local_rank", type=int, default=-1,
                    help="local_rank for distributed training on gpus")
parser.add_argument('--gradient_accumulation_steps', type=int, default=4,
                    help="Number of updates steps to accumulate before performing a backward/update pass.")
parser.add_argument('--smoothing_value', type=float, default=0.0,
                    help="Label smoothing value\n")

parser.add_argument('--split', type=str, default='non-overlap',
                    help="Split method")
parser.add_argument('--slide_step', type=int, default=12,
                    help="Slide step for overlap split")

parser.add_argument('--iter', default=1, type=int, metavar='N', help='iteration')
parser.add_argument('--expert-to-train', default="explainer", type=str, metavar='N',
                    help='which expert to train? explainer or residual')
parser.add_argument('--cov', nargs='+', default=[0.3, 0.4], type=float, help='coverage of the dataset')
parser.add_argument('--alpha', default=0.5, type=float, help='trade off for Aux explainer using Selection Net')
parser.add_argument('--selection-threshold', default=0.5, type=float,
                    help='selection threshold of the selector for the test/val set')
parser.add_argument('--lr-residual', '--learning-rate-residual', default=0.0001, type=float,
                    metavar='LR', help='initial learning rate of bb residual')
parser.add_argument('--momentum-residual', type=float, default=0.9, help='momentum for SGD')
parser.add_argument('--weight-decay-residual', type=float, default=1e-4, help='weight_decay for SGD')
parser.add_argument('--lr', '--learning-rate', nargs='+', default=[0.01, 0.001], type=float,
                    metavar='LR', help='initial learning rate')
parser.add_argument('--input-size-pi', default=1024, type=int,
                    help='input size of pi - 2048 for layer4 (ResNet) or 1024 for layer3 (ResNet) ')
parser.add_argument('--temperature-lens', default=0.7, type=float, help='temperature for entropy layer in lens')
parser.add_argument('--lambda-lens', default=0.0001, type=float, help='weight for entropy loss')
parser.add_argument('--alpha-KD', default=0.9, type=float, help='weight for KD loss by Hinton')
parser.add_argument('--temperature-KD', default=10, type=float, help='temperature for KD loss')
parser.add_argument('--conceptizator', default='identity_bool', type=str, help='activation')
parser.add_argument('--hidden-nodes', nargs="+", default=[10], type=int, help='hidden nodes of the explainer model')
parser.add_argument('--epochs', type=int, default=500, help='batch size for training the explainer - g')
parser.add_argument('--epochs-residual', type=int, default=50, help='batch size for training the residual')
parser.add_argument('--lm', default=64.0, type=float, help='lagrange multiplier for selective KD loss')
parser.add_argument('--prev_explainer_chk_pt_folder', metavar='path', nargs="+",
                    default=[
                        "root-path/checkpoints/HAM10k/explainer/lr_0.01_epochs_500_temperature-lens_0.7_input-size-pi_2048_cov_0.45_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.9_temperature-KD_10.0_hidden-layers_1/iter1",
                        "root-path/checkpoints/HAM10k/explainer/lr_0.01_epochs_500_temperature-lens_0.7_input-size-pi_2048_cov_0.45_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.9_temperature-KD_10.0_hidden-layers_1/cov_0.2/iter2"],
                    help='checkpoint file of residual')

parser.add_argument('--root-bb', metavar='file',
                    default='lr_0.001_epochs_300',
                    help='checkpoint folder of BB')
parser.add_argument('--checkpoint-bb', metavar='file',
                    default='g_best_model_epoch_299.pth.tar',
                    help='checkpoint file of BB')
parser.add_argument('--concept_file_name', type=str, default='RN50_10.0.pkl', help="concept_file_name")
parser.add_argument('--concept_path', type=str, default='root-path/out/CIFAR10/t', help="concept_path")
parser.add_argument('--concept_names', metavar='file', nargs="+",
                    default=['loudspeaker', 'microwave', 'arm', 'exhaust_hood', 'airplane', 'pedestal', 'back', 'mouse', 'glass', 'polka_dots', 'mouth', 'keyboard', 'inside_arm', 'bird', 'bedclothes', 'paper', 'blind', 'brick', 'stairs', 'countertop', 'base', 'person', 'blueness', 'bathroom_s', 'pane', 'motorbike', 'hair', 'paw', 'candlestick', 'outside_arm', 'ceiling', 'light', 'street_s', 'column', 'door_frame', 'granite', 'cow', 'sand', 'bottle', 'cup', 'plate', 'double_door', 'pillow', 'plant', 'doorframe', 'eyebrow', 'flower', 'horse', 'toilet', 'ceramic', 'greenness', 'back_pillow', 'drawer', 'coach', 'metal', 'lid', 'bannister', 'handle_bar', 'fan', 'bush', 'blotchy', 'fireplace', 'bowl', 'nose', 'leg', 'door', 'stripes', 'apron', 'oven', 'pack', 'body', 'foot', 'frame', 'dining_room_s', 'board', 'bridge', 'sofa', 'bedroom_s', 'head', 'blurriness', 'footboard', 'leather', 'hand', 'fluorescent', 'tree', 'knob', 'headlight', 'blackness', 'house', 'jar', 'mirror', 'pipe', 'bathtub', 'flag', 'refrigerator', 'curtain', 'book', 'coffee_table', 'field', 'chandelier', 'cap', 'hill', 'ashcan', 'path', 'counter', 'cardboard', 'desk', 'balcony', 'box', 'napkin', 'ear', 'food', 'manhole', 'chest_of_drawers', 'fence', 'building', 'figurine', 'lamp', 'basket', 'eye', 'ground', 'car', 'cat', 'bookcase', 'palm', 'water', 'bus', 'laminate', 'handle', 'painted', 'dog', 'bumper', 'concrete', 'awning', 'clock', 'faucet', 'headboard', 'canopy', 'bucket', 'drinking_glass', 'armchair', 'minibike', 'carpet', 'cabinet', 'bed', 'earth', 'neck', 'can', 'bicycle', 'bag', 'chain_wheel', 'beak', 'mountain', 'redness', 'air_conditioner', 'chair', 'engine', 'painting', 'grass', 'snow', 'pillar', 'chimney', 'floor', 'fabric', 'computer', 'flowerpot', 'muzzle', 'bench', 'ottoman', 'cushion'],
                    help='checkpoint file of residual')
parser.add_argument('--labels', nargs='+',
                    default=['airplane', 'automobile', 'bird', 'cat', 'deer', 'dog', 'frog', 'horse', 'ship', 'truck'])
parser.add_argument('--checkpoint-model', metavar='file', nargs="+",
                    default=['model_g_best_model_epoch_116.pth.tar', "model_g_best_model_epoch_365.pth.tar"],
                    help='checkpoint file of GatedLogicNet')

parser.add_argument('--checkpoint-residual', metavar='file', nargs="+",
                    default=['model_residual_best_model_epoch_2.pth.tar'],
                    help='checkpoint file of residual')
def main():
    print("Test GLT for CIFAR100")
    args = parser.parse_args()
    args.class_to_idx = {"benign": 0, "malignant": 1}
    train(args)


if __name__ == '__main__':
    main()
