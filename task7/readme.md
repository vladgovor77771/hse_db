# DB Task 7

## Build and run

Install node.js, then

```bash
npm install -g yarn
git clone https://github.com/vladgovor77771/hse_db
cd hse_db/task7
npx yarn install
./scripts/db_up.sh
./scripts/run_migrations.sh
npx ts-node run_seeds.ts
npx ts-node index.ts
./scripts/db_down.sh
```

## Описание

ORM модели в папке `./models`. Юзаю `typeorm`. Запросы из задания в файле `./queries/index.ts`
