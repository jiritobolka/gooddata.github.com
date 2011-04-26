includes:
	cd _includes/gdcl && git pull && cp -R cli-distro doc ../gdcl-static/

build: includes
	rm -f css/style.css
	jekyll
	cp _site/css/style.css css/style.css
	echo "\n\nReview repo changes > commit > push to Github\n"

run:
	rm -f css/style.css
	jekyll --server --auto