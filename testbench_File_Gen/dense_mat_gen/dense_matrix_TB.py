import numpy as np
import json 

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

def B_reverse(B_mat):
   B_rev= reversed_matrix = np.flip(B_mat, axis=1)
   return B_rev

def matmul (A , B):
    C = np.dot(A,B)
    return C

#  The command line template, For example:
#  python3 sparse_tb_gen.py -rows 8 -cols 8
parser = argparse.ArgumentParser(description="entering the input values")
parser.add_argument("-rows", "--rows_value", type=int, default=4, help="Value for rows")
parser.add_argument("-cols", "--cols_value", type=int, default=4, help="Value for cols")
parser.add_argument("-d", "--density", type=float, default=0.5, help="Density value")

args = parser.parse_args()
rows = args.rows_value
cols = args.cols_value
density = args.density



#Opening json file:
with open('input_values.json', 'r') as f:
    data = json.load(f)

# Reading input values
rows = data['rows']
cols = data['columns']

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