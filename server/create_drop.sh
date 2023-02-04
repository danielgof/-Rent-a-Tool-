# sudo -su postgres
echo "hello from sudo"
psql rt < 'dump.sql'