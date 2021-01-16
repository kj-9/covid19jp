data: .FORCE
	Rscript data-raw/execute.R
	find data/ -type f -print0 | sort -z | xargs -0 sha1sum | sort | sha1sum > inst/DATA_HASH

ga-commit:
ifeq ($(MAKE_ENV),GITHUB_ACTIONS)
	git config --local user.email "action@github.com"
	git config --local user.name "GitHub Action"
	git commit -m "Automatic data update" -a
else
	echo MAKE_ENV is: $(MAKE_ENV). not run.
endif

document:
	Rscript -e "devtools::document()"

test:
	Rscript -e "devtools::test()"

.FORCE:
.PHONY:
	data
	ga-commit
	document
	test
	install