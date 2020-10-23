#! /bin/sh

DB=connect_uzak
HOST=$MYSQL_HOST
USER=$MYSQL_USERNAME
PW=$MYSQL_PASSWORD

echo "drop schema $DB; create schema $DB; " | mysql -h $HOST -u $USER -p$PW $DB

(
    cd ~/repos/Prusa-Connect-MySQL
    ./bin/migrator.py  --database $DB --host $HOST -u $USER -p $PW Migrations/*
)

mysql -h $HOST -u $USER -p$PW $DB <<EOF
    insert into user(username,first_name,last_name,is_admin,password) values('martin', 'm', 'u', 1, 'a1333303f02ff10314ed48cefac4271194a2cb0d9d22ca570ebd641ca56c565dcf5b5834c1231827493c6a7c65aed045acb60e21182ecea734dda66ecfb28c038e5edd5a9b6d54e6adc0fe7d6de6e03ce41bfacbba6799b643c2149553f3a8db');
    insert into team(name) values ('martin');
    update user set default_team_id=(select id from team where name='martin') where username='martin';
    insert into user_team(user_id, team_id, rights_ro, rights_rw, rights_use) values((select id from user where username='martin'), (select id from team where name='martin'), 1, 1, 1);
EOF
