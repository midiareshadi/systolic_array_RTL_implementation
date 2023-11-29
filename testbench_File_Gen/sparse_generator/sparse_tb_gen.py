import numpy as np
import os
from scipy.sparse import random
from scipy import stats
from scipy import sparse
from scipy.sparse import csr_matrix
from numpy.random import default_rng

rows = 400
cols = 400
density=0.8

def sparse_matrix_gen(m,n, density,seed):
	np.random.seed(seed)
	data_rvs = lambda n: np.random.randint(low=0, high=8, size=n, dtype=np.uint8)
	sparse_gen_mat = sparse.random(m, n, density=density, format='csr', data_rvs=data_rvs)
	sparse_gen_mat=sparse_gen_mat.toarray()
	return sparse_gen_mat
	
	
def dense_matrix_gen(m,n):
	rng = np.random.default_rng()
	dens_gen_mat= rng.integers(low=1, high=7, size=(m, n), dtype=np.uint8, endpoint=False)
	return dens_gen_mat

def add_zeros(A_mat):
    n = A_mat.shape[0]
    m = A_mat.shape[1]
    new_matrix = np.zeros((n + m - 1, m))
    for i in range(n):
        for j in range(m):
            new_matrix[i + j][j] = A_mat[i][j]

    return new_matrix

def add_zeros_2(in_matrix):
    n = in_matrix.shape[0]
    m = in_matrix.shape[1]
    new_matrix = np.zeros((n, n + m - 1))
    for i in range(n):
        for j in range(m):
            new_matrix[i][i+j] = in_matrix[i][j]

    return new_matrix

def B_reverse(B_mat):
   B_rev= reversed_matrix = np.flip(B_mat, axis=1)

   return B_rev

def matmul (A , B):
    C = np.dot(A,B)

    return C

# Generating matrices
A=sparse_matrix_gen(1,cols,density,12)
B=sparse_matrix_gen(rows,1,density,14)
np.savetxt('A.txt', A, fmt='%d')
np.savetxt('B.txt', B, fmt='%d')

"""
# Loading matrices
#A_mat = np.loadtxt('A.txt')
#B_mat = np.loadtxt('B.txt')
"""

# Function calls
C= matmul (A , B)
A_mat = np.flip(A, axis=0)
B_mat = B

# Saving matrices
np.savetxt('A_TB.txt', A_mat, fmt='%d')
np.savetxt('B_TB.txt', B_mat, fmt='%d')
np.savetxt('C_matmul.txt', C, fmt='%d')