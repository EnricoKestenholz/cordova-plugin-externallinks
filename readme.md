Cordova IOS externalLinks plugin
==================================

This plugin will block any url other than file:// to be showed in the main cordova webview and instead open them with the system web browser.

This fixes an issue where allow-navigation in iOS is used for both iframes and main navigation.

With this plugin allow-navigation will only handle iframes on iOS.


### Sample usage ###

cordova plugin add https://github.com/EnricoKestenholz/cordova-plugin-externallinks


### Copyrights ###
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
