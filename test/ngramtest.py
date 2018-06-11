import ngram

text = 'あいうえお'
tt="aaa"
jj="bba"

print(ngram.NGram.compare(tt, jj, N=1))

index = ngram.NGram(N=2)
for term in index.ngrams(index.pad(text)):
	print(term)
