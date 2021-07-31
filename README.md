# Side-Window-Box-Filtering
- Based on YuanhaoGong/SideWindowFilter (https://github.com/YuanhaoGong/SideWindowFilter) open source.
- Adding HSI datasets and some filtering code ( all data were classified using SVM ). Some codes need to obtain MATLAB filtered data in advance( Some datasets are too large and cannot be uploaded to the GitHub ). 

## Parameter:
The data sets and  number of training samples can be selected within the code.  
- DataSetName in {'Indianpines', 'Salinas', 'PaviaU'}
- classifier in {'box', 'sw_box', 'adapt_sw_box', 'gabor', 'gf', 'pf', 'lbp', 'bf', 'dtrf', 'cf'}
- train_number indicates the number of training samples selected for each category.
- o_p_r is used to choose whether to adopt PCA preprocessing, 0 for False 1 for True.
- iter is used to set the total number of iterations, and the number of iter is only valid for the algorithm proposed in this paper.

## Usage:
For example, when DataSet Indianpines takes 5-30 training sample points for each class after dimention reduction of PCA, the method of calling sw_box algorithm for 10 iterations is as follows:
- final_filtering('Indianpines', 'sw_box', [5,10,15,30], 1, 10) 

Then the results are then automatically saved to file "all_result.txt".

