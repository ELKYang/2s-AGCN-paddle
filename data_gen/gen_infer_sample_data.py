import os.path
import argparse
import numpy as np
import pickle


def get_args(add_help=True):
    """
    parse args
    """
    parser = argparse.ArgumentParser(
        description="gen sample data", add_help=add_help)

    parser.add_argument(
        '--data-path',
        type=str,
        default='../data/ntu/xview/val_data_joint.npy',
        help='Data path of val_data')
    parser.add_argument(
        '--label-path',
        type=str,
        default='../data/ntu/xview/val_label.pkl',
        help='Data path of val_label')
    parser.add_argument(
        '--save-dir',
        type=str,
        default='../data/ntu/xview',
        help='save path of result data')
    parser.add_argument(
        '--data-num',
        type=int,
        default=10,
        help='data num of result data')

    args = parser.parse_args()
    return args


def gen_tiny_data(data_path, label_path, save_dir, data_num, use_mmap=True):
    if use_mmap:
        data = np.load(data_path, mmap_mode='r')
    else:
        data = np.load(data_path)
    try:
        with open(label_path) as f:
            sample_name, label = pickle.load(f)
    except:
        # for pickle file from python2
        with open(label_path, 'rb') as f:
            sample_name, label = pickle.load(f, encoding='latin1')

    label = label[0:data_num]
    data = data[0:data_num]
    sample_name = sample_name[0:data_num]

    tiny_data = {'label': label, 'data': data, 'sample_name': sample_name}
    with open(os.path.join(save_dir, "tiny_data.pkl"), "wb") as pk:
        pickle.dump(tiny_data, pk)


if __name__ == "__main__":
    args = get_args()
    gen_tiny_data(data_path=args.data_path, label_path=args.label_path,
                  save_dir=args.save_dir, data_num=args.data_num)



