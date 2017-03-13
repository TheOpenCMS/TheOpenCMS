### HOW TO UPDATE SOURCES

#### Rubygems.org

`lib/protozaur/version.rb`

`gem build protozaur.gemspec`

`gem push protozaur-X.X.X.gem`

#### NPM packages

`package.json`

`npm adduser`

`npm publish`

#### Bower

`npm install -g bower`

`bower.json`

`bower register protozaur git@github.com:the-teacher/protozaur.git`

#### GitHub/tag

`git tag vX.X.X`

`git push origin vX.X.X`
