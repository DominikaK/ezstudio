#!/bin/bash
# Script used to prepare for eZ Platform/Studio archives
#
# Pre-requirement for eZ Studio archives:
#     auth.json needs to be placed in either root directory or COMPOSER_HOME.
#     If auth.json is placed in COMPOSER_HOME, it needs to be for same user as the one executing script.


# Install all composer deps non-interactivly
composer install -n --prefer-dist --no-dev --no-scripts

# Rename .gitignore to make it optional as it is optimized for kernel development and not project development
mv .gitignore .gitignore.dist

# Archive: Remove cache (wrong paths), logs (generated by composer call above) & zeta tests (too big)
rm -Rf app/cache/*/* app/logs/* vendor/zetacomponents/*/tests

echo << EOF
Ready to archive the result

Assuming current folder is build/ezplatform this can be accomplished in the following way:
    cd ../..
    tar czf dist/ezplatform-\$version-ee-gpl-full.tar.gz --directory=build ezplatform
EOF
