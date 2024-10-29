invoke getfileattributes, <FileName>

cmp eax, -1

je not_found

not_found:
invoke EXITPROCESS, 0
