#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
set -e

# Preamble
client_library_name=$(basename "$(dirname "$PWD")")
read -r -n 1 -p "The client name will be '$client_library_name'. Press any key to continue. Press Ctrl+C to stop now."$'\n'

# Ensure dependencies
export PATH="$PATH":"$HOME/.puro/shared/pub_cache/bin"
dart pub global activate openapi_generator_cli
# Puro proxying
if command -v puro &> /dev/null; then
  # shellcheck disable=SC2317
  flutter() { puro flutter "$@"; };
  dart() { puro dart "$@"; };
  export -f flutter;
  export -f dart;
fi

# Declarations
api_version_tag="3"

# Cleanup the repo from any previous runs
cd ..
rm -rf .openapi-generator/
rm -rf doc/
rm -rf lib/
rm -rf test/
rm -f ./*.yaml
rm -f README.md
rm -f pubspec.lock




# Execute openapi-generator generator
openapi-generator generate                                                                                              \
        -i https://petstore3.swagger.io/api/v${api_version_tag}/openapi.json                                            \
        -g dart-dio                                                                                                     \
        -o .                                                                                                            \
        --additional-properties pubName="${client_library_name}"                                                        \
        --additional-properties pubLibrary="${client_library_name}".api                                                 \
        --additional-properties pubVersion="${api_version_tag}".0.0                                                     \
        --additional-properties pubAuthor="$(git config --local user.name)"                                             \
        --additional-properties pubAuthorEmail="$(git config --local user.email)"                                       \
        --additional-properties pubHomepage="https://github.com/$(git config --local user.name)/${client_library_name}" \
        --additional-properties pubPublishTo="https://pub.dev"                                                                  \
        --additional-properties pubDescription="Petstore OpenAPI API client"                                            \
        --additional-properties serializationLibrary="json_serializable"
# Cleanup
dart pub global deactivate openapi_generator_cli




# Add copyWith annotations
dart pub add copy_with_extension
dart pub add --dev copy_with_extension_gen

# Annotate every class with `CopyWith`
find lib/src/model -type f -name '*.dart' | while read -r file; do
# Insert import if missing
grep -q "copy_with_extension" "$file" || sed -i '' "/package:json_annotation/a\\
import 'package:copy_with_extension/copy_with_extension.dart';
" "$file"

# Insert @CopyWith() if missing
grep -q "@CopyWith" "$file" || sed -i '' "/@JsonSerializable/i\\
@CopyWith()
" "$file"
done




# Pregen fixes
read -r -n 1 -p "Please ensure that the Dart SDK (min) constraints in pubspec.yaml support null-aware-elements (3.8.1). Press ENTER to confirm and proceed. Press Ctrl+C to stop now."$'\n'




# Run build_runner
dart run build_runner build --delete-conflicting-outputs




# Fixes
dart fix --apply && dart format .

# Postamble
read -r -n 1 -p "CLEANUP DONE!. Press any key to exit..."
exit 0
