
build:
	.tools/node/node_modules/sass/sass.js src/sass/light_theme_archive.scss static/css/light_theme_archive.css -s compressed
	.tools/node/node_modules/sass/sass.js src/sass/light_theme_normal.scss static/css/light_theme_normal.css -s compressed
	.tools/node/node_modules/sass/sass.js src/sass/light_theme_preliminary.scss static/css/light_theme_preliminary.css -s compressed
	.tools/node/node_modules/sass/sass.js src/sass/dark_theme_archive.scss static/css/dark_theme_archive.css -s compressed
	.tools/node/node_modules/sass/sass.js src/sass/dark_theme_normal.scss static/css/dark_theme_normal.css -s compressed
	.tools/node/node_modules/sass/sass.js src/sass/dark_theme_preliminary.scss static/css/dark_theme_preliminary.css -s compressed
	.tools/node/node_modules/uglify-js/bin/uglifyjs src/js/misc.js src/js/prism.js --compress -o static/js/all.min.js
	.tools/node/node_modules/uglify-js/bin/uglifyjs src/js/styleSwitcher.js --compress -o static/js/styleSwitcher.min.js

lint: style spell proof

prep: prep_build prep_lint

prep_build:
	npm install --prefix .tools/node sass
	npm install --prefix .tools/node uglify-js

prep_lint:
	gem install html-proofer --install-dir .tools
	gem install mdl --install-dir .tools
	npm install --prefix .tools/node markdown-spellcheck

proof:
	.tools/bin/htmlproofer ./public --check-html --assume-extension --timeframe 2d --storage-dir .htmlproofer --url-ignore "/localhost/,/github.com/istio/istio.github.io/edit/master/"

style:
	.tools/bin/mdl --ignore-front-matter --style mdl_style.rb .

spell:
	.tools/node/node_modules/markdown-spellcheck/bin/mdspell --en-us --ignore-acronyms --ignore-numbers --no-suggestions --report */*.md */*/*.md */*/*/*.md */*/*/*/*.md */*/*/*/*/*.md  */*/*/*/*/*/*.md  */*/*/*/*/*/*/*.md
