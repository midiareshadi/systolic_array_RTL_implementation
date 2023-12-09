import numpy as np
import os
import sys
import json
import matplotlib.pyplot as plt
from scipy.sparse import random
from scipy import stats
from scipy import sparse
from scipy.sparse import csr_matrix
from numpy.random import default_rng

# Sparse matrix generator function
def sparse_matrix_gen(m,n, density,seed):
	np.random.seed(seed)
	data_rvs = lambda n: np.random.randint(low=0, high=8, size=n, dtype=np.uint8)
	sparse_gen_mat = sparse.random(m, n, density=density, format='csr', data_rvs=data_rvs)
	sparse_gen_mat=sparse_gen_mat.toarray()
	return sparse_gen_mat
	
# Matrix numpy matmul function
def matmul (A , B):
    C = np.dot(A,B)
    return C

# Matrix heatmap generator function
def heat_Func (matrix,index):
	plt.spy(matrix, markersize=0.5)
	plt.savefig(os.path.join('MatHeatMap/', f'{index}heatmap.png'), dpi=50)
	plt.close()

# Opening json file:
with open('input_values.json', 'r') as f:
    data = json.load(f)

# Reading input values
rows = data['rows']
cols = data['columns']
density = data['density']
HeatmapGen = data ['heatmap_generation']

rows = int(rows)
cols = int(cols)
density = float (density)
HeatmapGen= bool (HeatmapGen)

if HeatmapGen is True:
	print ('Genetares input matrices for a', rows, 'by', cols, \
	'systolic array with density = ', density, 'with matrix heatmap generation' )
else:
	print ('Genetares input matrices for a', rows, 'by', cols, \
	'systolic array with density = ', density, ' _without_ matrix heatmap generation' )

# Generating sparse matrices
A=sparse_matrix_gen(rows,cols,density,12)
B=sparse_matrix_gen(rows,cols,density,14)

# Printing matrices A and B (For running in playgroung)
print ("\n****** matrix A ******\n")
np.savetxt(sys.stdout, A, fmt='%d', delimiter=' ')
print ("\n***** matrix B *****\n")
np.savetxt(sys.stdout, B, fmt='%d', delimiter=' ')

# Store matrices A and B in usual format
np.savetxt(os.path.join('Reg_Format/', 'A.txt'), A, fmt='%d')
np.savetxt(os.path.join('Reg_Format/', 'B.txt'), B, fmt='%d')

# Heatmap generation function call
if HeatmapGen is True :
	heat_Func (A,'A_')
	heat_Func (B,'B_')

# Loading matrices
A_mat = np.loadtxt(os.path.join('Reg_Format/', 'A.txt'))
B_mat = np.loadtxt(os.path.join('Reg_Format/', 'B.txt'))

# Function calls
C= matmul (A , B)
A_mat = np.flip(A, axis=0)
B_mat = B

# Printing matrices A_TB and B_TB (zero padded for testbench)
print ("\n**** matrix A_TB *****\n")
np.savetxt(sys.stdout, A_mat, fmt='%d', delimiter=' ')
print ("\n**** matrix B_TB *****\n")
np.savetxt(sys.stdout, B_mat, fmt='%d', delimiter=' ')
print ("\n**********************\n")

# Saving matrices
np.savetxt(os.path.join('TB_Format/', 'A_TB.txt'), A_mat, fmt='%d')
np.savetxt(os.path.join('TB_Format/', 'B_TB.txt'), B_mat, fmt='%d')
np.savetxt(os.path.join('Reg_Format/', 'C_matmul.txt'), C, fmt='%d')