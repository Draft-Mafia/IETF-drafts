
SUBDIRS = TURN-SSODA ICE-DualStackFairnes MALICE
CLEANDIRS = $(SUBDIRS:%=clean-%)


.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

$(SUBDIRS):
ifeq (,$(wildcard $@/Makefile))
    #$(error GNU Sort does not exist!)
	cp Makefile.template $@/Makefile	
endif 
	$(MAKE) -C $@


clean: $(CLEANDIRS)
$(CLEANDIRS): 
	$(MAKE) -C $(@:clean-%=%) clean


### Below this deals with updating gh-pages

#GHPAGES_TMP := /tmp/ghpages$(shell echo $$$$)
#.TRANSIENT: $(GHPAGES_TMP)
#ifeq (,$(TRAVIS_COMMIT))
#GIT_ORIG := $(shell git branch | grep '*' | cut -c 3-)
#else
#GIT_ORIG := $(TRAVIS_COMMIT)
#endif

# Only run upload if we are local or on the master branch
#IS_LOCAL := $(if $(TRAVIS),,true)
#ifeq (master,$(TRAVIS_BRANCH))
#IS_MASTER := $(findstring false,$(TRAVIS_PULL_REQUEST))
#else
#IS_MASTER :=
#endif
#
#index.html: $(draft).html
#	cp $< $@
#
#ghpages: index.html $(draft).txt
#ifneq (,$(or $(IS_LOCAL),$(IS_MASTER)))
#	mkdir $(GHPAGES_TMP)
#	cp -f $^ $(GHPAGES_TMP)
#	git clean -qfdX
#ifeq (true,$(TRAVIS))
#	git config user.email "ci-bot@example.com"
#	git config user.name "Travis CI Bot"
#	git checkout -q --orphan gh-pages
#	git rm -qr --cached .
#	git clean -qfd
#	git pull -qf origin gh-pages --depth=5
#else
#	git checkout gh-pages
#	git pull
#endif
#	mv -f $(GHPAGES_TMP)/* $(CURDIR)
#	git add $^
#	if test `git status -s | wc -l` -gt 0; then git commit -m "Script updating gh-pages."; fi
#ifneq (,$(GH_TOKEN))
#	@echo git push https://github.com/$(TRAVIS_REPO_SLUG).git gh-pages
#	@git push https://$(GH_TOKEN)@github.com/$(TRAVIS_REPO_SLUG).git gh-pages
#endif
#	-git checkout -qf "$(GIT_ORIG)"
#	-rm -rf $(GHPAGES_TMP)
#endif
