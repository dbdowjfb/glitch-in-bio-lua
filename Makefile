all:
	rm ./build/* || true
	cp styles build -r
	pandoc index.html --lua-filter ./scripts/filter.lua -o build/index.html \
	--template template.html

serve:
	python -m http.server --directory build --bind localhost
