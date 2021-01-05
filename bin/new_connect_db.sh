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
    insert into user(username,first_name,last_name,is_admin,password) values('martin', 'm', 'u', 1, '95398920532e39f045d4faf3da7acddfb5ab12bf9db36c9fa49c5e5e2b0d7a42a1226f39bbf7603a41eade1b1f74937e9d440b28105588bf22ce1f655004b21ca396c9638ccef3716e8ec472f9761b99f96d2cf22a659840d1d00e23414b0f7f');
    insert into team(name) values ('martin');
    update user set default_team_id=(select id from team where name='martin') where username='martin';
    insert into user_team(user_id, team_id, rights_ro, rights_rw, rights_use) values((select id from user where username='martin'), (select id from team where name='martin'), 1, 1, 1);
EOF

# INFLUX
DB=connect_uzak

echo "drop database $DB" | influx -host $INFLUX_HOST
echo "create database $DB" | influx -host $INFLUX_HOST

