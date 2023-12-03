import numpy as np
import argparse
import os
import sys
from scipy.sparse import random
from scipy import stats
from scipy import sparse
from scipy.sparse import csr_matrix
from numpy.random import default_rng

def sparse_matrix_gen(m,n, density,seed):
	np.random.seed(seed)
	data_rvs = lambda n: np.random.randint(low=0, high=8, size=n, dtype=np.uint8)
	sparse_gen_mat = sparse.random(m, n, density=density, format='csr', data_rvs=data_rvs)
	sparse_gen_mat=sparse_gen_mat.toarray()
	return sparse_gen_mat
	
def matmul (A , B):
    C = np.dot(A,B)
    return C

#  The command line template, For example:
#  python3 sparse_tb_gen.py -rows 8 -cols 8 -d 0.7")
parser = argparse.ArgumentParser(description="entering the input values")
parser.add_argument("-rows", "--rows_value", type=int, default=4, help="Value for rows")
parser.add_argument("-cols", "--cols_value", type=int, default=4, help="Value for cols")
parser.add_argument("-d", "--density", type=float, default=0.5, help="Density value")

args = parser.parse_args()
rows = args.rows_value
cols = args.cols_value
density = args.density

# Generating sparse matrices
A=sparse_matrix_gen(rows,cols,density,12)
B=sparse_matrix_gen(rows,cols,density,14)

# Printing matrices A and B (For running in playgroung)
print ("\n****** matrix A ******\n")
np.savetxt(sys.stdout, A, fmt='%d', delimiter=' ')
print ("\n***** matrix B *****\n")
np.savetxt(sys.stdout, B, fmt='%d', delimiter=' ')

# Store matrices A and B in usual format
np.savetxt('A.txt', A, fmt='%d')
np.savetxt('B.txt', B, fmt='%d')

# Loading matrices
A_mat = np.loadtxt('A.txt')
B_mat = np.loadtxt('B.txt')

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
np.savetxt('A_TB.txt', A_mat, fmt='%d')
np.savetxt('B_TB.txt', B_mat, fmt='%d')
np.savetxt('C_matmul.txt', C, fmt='%d')