import numpy as np

# Matrix generator function with random elements
def dense_matrix_generation(rows,cols):
    rng = np.random.default_rng()
    A = rng.integers(low=1, high=15, size=(rows, cols), dtype=np.uint8, endpoint=False)
    B = rng.integers(low=1, high=15, size=(rows, cols), dtype=np.uint8, endpoint=False)
    np.savetxt('A.txt', A, fmt='%d')
    np.savetxt('B.txt', B, fmt='%d')

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

# Getting the dimension of the systolic array
rows, cols = input("Enter the systolic array dimensions separated by a comma: ").split(",")
rows = int(rows)
cols = int(cols)
print ('Genetares input matrices for a', rows, 'by', cols, 'systolic array')

# Generating matrices
dense_matrix_generation(rows, cols)

# Loading matrices
A_mat = np.loadtxt('A.txt')
B_mat = np.loadtxt('B.txt')

# Function calls
C= matmul (A_mat , B_mat)
A_mat = np.transpose(A_mat)
A_mat = add_zeros(A_mat)
B_final=add_zeros(B_mat)

"""
# Weight stationary input matrices
# B_mat= B_reverse(B_mat) # for weight stationaty
# B_flip= np.flip(B_mat, axis=0)
"""

# Saving matrices
np.savetxt('A_TB.txt', A_mat, fmt='%d')
np.savetxt('B_TB.txt', B_final, fmt='%d')
np.savetxt('C_matmul.txt', C, fmt='%d')