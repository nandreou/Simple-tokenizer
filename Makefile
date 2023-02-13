bin= tokenizer
flex-c-file=lex.yy.c
src= tokenizer.l

${bin}: ${flex-c-file}
	clang -o $@ $^

${flex-c-file}: ${src}
	flex $^

clear:
	rm ${bin} ${flex-c-file}
