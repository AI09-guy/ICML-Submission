#!/bin/sh
#SBATCH --output=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/t/CNN/%j_bash_run_explainer.out
pwd; hostname; date
CURRENT=`date +"%Y-%m-%d_%T"`
echo $CURRENT
slurm_output=/ocean/projects/asc170022p/shg121/PhD/ICLR-2022/psclogs/t/CNN/run_explainer_$CURRENT.out
echo "MIMIC_CXR"
source /ocean/projects/asc170022p/shg121/anaconda3/etc/profile.d/conda.sh
# conda activate python_3_7

conda activate python_3_7_rtx_6000

# python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/train_t_mimic_cxr.py \
#   --arch='densenet121' \
#   --workers=5 \
#   --epochs=60 \
#   --start-epoch=0 \
#   --batch-size=16 \
#   --learning-rate=0.01 \
#   --loss1="BCE_W"\
#   --resize=512 \
#   --resume='' \
#   --gpu=0 \
#   --world-size=1 \
#   --rank=0 \
#   --ngpus-per-node=2 \
#   --bb-chkpt-folder="lr_0.01_epochs_60_loss_CE"\
#   --checkpoint-bb="g_best_model_epoch_4.pth.tar"\
#   --flattening-type="flatten" \
#   --layer="features_denseblock4" \
#   --selected-obs="cardiomegaly" \
#   --labels "0 (No Cardiomegaly)" "1 (Cardiomegaly)"> $slurm_output


python /ocean/projects/asc170022p/shg121/PhD/ICLR-2022/codebase/test_t_mimic_cxr.py \
  --arch='densenet121' \
  --workers=5 \
  --epochs=60 \
  --start-epoch=0 \
  --batch-size=1 \
  --learning-rate=0.01 \
  --loss1="BCE_W"\
  --resize=512 \
  --resume='' \
  --gpu=0 \
  --world-size=1 \
  --rank=0 \
  --ngpus-per-node=2 \
  --bb-chkpt-folder="lr_0.01_epochs_60_loss_CE"\
  --checkpoint-bb="g_best_model_epoch_4.pth.tar"\
  --flattening-type="flatten" \
  --layer="features_denseblock4" \
  --checkpoint-t="g_best_model_epoch_10.pth.tar"\
  --selected-obs="cardiomegaly" \
  --labels "0 (No Cardiomegaly)" "1 (Cardiomegaly)"> $slurm_output