# Setup

Щоб швидко виконати всю підгтовочу роботу слід запустити скрипт ```bin/setup```.

```
git clone git@github.com:paveldruzyak/eattogether-web.git
cd eattogether-web
cp config/database.yml.example config/database.yml # update username/password
bin/setup
```

# Run

 Foreman дозволяє запустити одразу все, що потрібно для проекта однією командою. А якщо ще й встановлений ```pow```, то замість ```localhost``` у браузері можно буде набрати ```eattogether-web.dev```.

```
foreman start
open http://eattogether-web.dev
```
