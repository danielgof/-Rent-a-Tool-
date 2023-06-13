from cassandra.cluster import Cluster

cluster = Cluster(['192.168.0.1', '192.168.0.2'])
session = cluster.connect()

print(session.execute("SELECT release_version FROM system.local").one())