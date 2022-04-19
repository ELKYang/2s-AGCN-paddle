#!/bin/bash
source test_tipc/common_func.sh

FILENAME=$1
# MODE be one of ['lite_train_lite_infer' 'lite_train_whole_infer' 'whole_train_whole_infer', 'whole_infer', 'klquant_whole_infer']
MODE=$2

dataline=$(awk 'NR==1, NR==51{print}'  $FILENAME)

# parser params
IFS=$'\n'
lines=(${dataline})

# The training params
model_name=$(func_parser_value "${lines[1]}")
python=$(func_parser_value "${lines[2]}")
main=$(func_parser_value "${lines[3]}")
ensemble=$(func_parser_value "${lines[4]}")
config_train=$(func_parser_value "${lines[5]}")

# The testing params
config_test=$(func_parser_value "${lines[7]}")
weights=$(func_parser_value "${lines[8]}")


# The inference params
prepare_data=$(func_parser_value "${lines[10]}")
dataset=$(func_parser_value "${lines[11]}")
stream=$(func_parser_value "${lines[12]}")
data_num=$(func_parser_value "${lines[13]}")
export_tool=$(func_parser_value "${lines[14]}")
model_path=$(func_parser_value "${lines[15]}")
export_batch_size=$(func_parser_value "${lines[16]}")

infer_tool=$(func_parser_value "${lines[17]}")


function fun_train(){
    _python=$1
    _main=$2
    _config=$3
    _lite=$4

    command="${_python} ${_main} --config ${_config} --lite=${_lite}"
    eval $command
}


function fun_test(){
    _python=$1
    _main=$2
    _config=$3
    _weights=$4
    _mode=$5

    command="${_python} ${_main} --config ${_config} --weights ${_weights}"
    eval $command
}

function fun_prepare_data(){
    _python=$1
    _prepare_data=$2
    _dataset=$3
    _mode=$4
    _data_num=$5

    command="${_python} ${_prepare_data} --dataset=${_dataset} --mode=${_mode} --data-num=${_data_num}"
    eval $command
}


function fun_export(){
    _python=$1
    _tool=$2
    _model_path=$3
    _bs=$4

    command="${_python} ${_tool} --model_path=${_model_path} --batch=${_bs}"
    eval $command
}

function fun_infer(){
    _python=$1
    _tool=$2

    command="${_python} ${_tool}"
    eval $command
}

if [ ${MODE} = "whole_train_lite_infer" ];then
    fun_train "${python}" "${main}" "${config_train}" "False"
    fun_export "${python}" "${export_tool}" "${model_path}" "${export_batch_size}"
    fun_prepare_data "${python}" "${prepare_data}" "${dataset}" "${stream}" "${data_num}"
    fun_infer "${python}" "${infer_tool}"

elif [ ${MODE} = "lite_train_lite_infer" ];then
    fun_train "${python}" "${main}" "${config_train}" "True"
    fun_export "${python}" "${export_tool}" "${model_path}" "${export_batch_size}"
    fun_prepare_data "${python}" "${prepare_data}" "${dataset}" "${stream}" "${data_num}"
    fun_infer "${python}" "${infer_tool}"

fi
