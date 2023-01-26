#!/bin/sh
#SBATCH --output=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/iter1/iter_5_VIT_g_train_%j.out
pwd; hostname; date
CURRENT=`date +"%Y-%m-%d_%T"`
echo $CURRENT
slurm_output=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/awa2/iter1/iter_5_VIT_g_train_$CURRENT.out
echo "Awa2"
source /ocean/projects/asc170022p/shg121/anaconda3/etc/profile.d/conda.sh
# conda activate python_3_7

conda activate python_3_7_rtx_6000

# Cum performance
# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/cum_performance.py --seed 3 --iterations 3 --dataset "awa2" --arch "ViT-B_16"
# Accuracy Mean (std dev): 0.9832486853418096 (0.004397714219699667)
# Auroc Mean (std dev): 0.5 (0.0)
# Recall Mean (std dev): 0.9112082849737894 (0.010654347502452062)
# Precision Mean (std dev): 0.9368617362568545 (0.0069720555137704155)
# F1 Mean (std dev): 0.9157611590420792 (0.008157606355787573)
# Save at: /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/out/awa2/soft_concepts/performance_metrics/ViT-B_16

# Training scripts
#---------------------------------
# # iter 1 
#---------------------------------
# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 150 --seed 3 --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 1 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --with_seed "y" --soft "y" --epochs 150 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 1 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 150 --epochs-residual 3 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 1 --expert-to-train "residual" --dataset "awa2" --cov 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output



#---------------------------------
# # iter 2
#---------------------------------

# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 2 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 2 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --epochs-residual 3 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1"  --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 2 --expert-to-train "residual" --dataset "awa2" --cov 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


#---------------------------------
# # iter 3
#---------------------------------

# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 3 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 3 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --epochs-residual 3 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 3 --expert-to-train "residual" --dataset "awa2" --cov 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output



#---------------------------------
# # iter 4
#---------------------------------

# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter3" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 4 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter3" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 4 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --epochs-residual 5 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter3" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 4 --expert-to-train "residual" --dataset "awa2" --cov 0.2 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output


#---------------------------------
# # iter 5
#---------------------------------

python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_explainer_awa2.py --with_seed "y" --soft "y" --epochs 50 --seed 3 --checkpoint-model "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" "model_g_best_model.pth.tar" --checkpoint-residual "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" "model_residual_best_model.pth.tar" --prev_explainer_chk_pt_folder "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_150_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/iter1" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter2" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter3" "/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/checkpoints/awa2/{soft_hard_filter}_concepts/seed_{seed}/explainer/ViT-B_16/lr_0.01_epochs_50_temperature-lens_6.0_use-concepts-as-pi-input_True_input-size-pi_2048_cov_0.2_alpha_0.5_selection-threshold_0.5_lambda-lens_0.0001_alpha-KD_0.99_temperature-KD_10.0_hidden-layers_1_layer_VIT_explainer_init_none/cov_0.2_lr_0.01/iter4" --root-bb "lr_0.03_epochs_95" --checkpoint-bb "VIT_CUBS_700_checkpoint.bin" --iter 5 --expert-to-train "explainer" --dataset "awa2" --cov 0.2 0.2 0.2 0.2 0.2 --bs 30 --dataset-folder "lr_0.03_epochs_95_ViT-B_16_layer4_VIT_sgd_BCE" --lr 0.01 0.01 0.01 0.01 0.01 --input-size-pi 2048 --temperature-lens 6.0 --lambda-lens 0.0001 --alpha-KD 0.99 --temperature-KD 10 --hidden-nodes 10 --layer "VIT" --arch "ViT-B_16" > $slurm_output







