#/bin/bash

cd "$(dirname "$0")/.."
npx ts-node ./node_modules/typeorm/cli.js migration:revert -d ./db/ormconfig.ts