#!/bin/sh
#SBATCH --output=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/awa2_VIT_%j.out
pwd; hostname; date
CURRENT=`date +"%Y-%m-%d_%T"`
echo $CURRENT
slurm_output1=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/awa2_VIT_iter1_$CURRENT.out
slurm_output2=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/awa2_VIT_iter2_$CURRENT.out
slurm_output3=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/awa2_VIT_iter3_$CURRENT.out
slurm_output4=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/awa2_VIT_iter4_$CURRENT.out
slurm_output5=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/awa2_VIT_iter5_$CURRENT.out
slurm_output6=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/awa2_VIT_iter6_$CURRENT.out

echo "Awa2"
source /ocean/projects/asc170022p/shg121/anaconda3/etc/profile.d/conda.sh
conda activate python_3_7_rtx_6000

# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/BB/VIT/TransFG-master/train_awa2.py > $slurm_output


python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --checkpoint-model "model_g_best_model_epoch_4.pth.tar" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 1 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output1

python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --checkpoint-model "model_g_best_model_epoch_4.pth.tar" "model_g_best_model_epoch_5.pth.tar" --checkpoint-residual "model_residual_best_model_epoch_1.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 2 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output2

python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --checkpoint-model "model_g_best_model_epoch_4.pth.tar" "model_g_best_model_epoch_5.pth.tar" "model_g_best_model_epoch_1.pth.tar" --checkpoint-residual "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 3 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output3

python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --checkpoint-model "model_g_best_model_epoch_4.pth.tar" "model_g_best_model_epoch_5.pth.tar" "model_g_best_model_epoch_1.pth.tar" "model_g_best_model_epoch_1.pth.tar" --checkpoint-residual "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter3" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 4 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output4

python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --checkpoint-model "model_g_best_model_epoch_4.pth.tar" "model_g_best_model_epoch_5.pth.tar" "model_g_best_model_epoch_1.pth.tar" "model_g_best_model_epoch_1.pth.tar" "model_g_best_model_epoch_1.pth.tar" --checkpoint-residual "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter3" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter4" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 5 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16"> $slurm_output5

python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --checkpoint-model "model_g_best_model_epoch_4.pth.tar" "model_g_best_model_epoch_5.pth.tar" "model_g_best_model_epoch_1.pth.tar" "model_g_best_model_epoch_1.pth.tar" "model_g_best_model_epoch_1.pth.tar" "model_g_best_model_epoch_1.pth.tar" --checkpoint-residual "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" "model_residual_best_model_epoch_1.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter3" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter4" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/explainer/ViT-B_16/lr_0.01_epochs_500_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter5" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 6 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output6

