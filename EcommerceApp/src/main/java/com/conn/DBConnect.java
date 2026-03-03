package com.conn;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
 
/**
 * DBConnect
 * - Reads DB settings from environment variables (best with --env-file .env)
 * - Defaults are sensible for local/dev
 *
 * Required env vars (with defaults):
 *   DB_HOST (default: 10.0.1.102)
 *   DB_PORT (default: 3306)
 *   DB_NAME (default: ecomdb)
 *   DB_USER (default: ecomuser)
 *   DB_PASS (default: ecomPass123!)
 */
public class DBConnect {
 
    private static volatile Connection conn = null;
 
    private static String getenv(String key, String def) {
        String v = System.getenv(key);
        return (v == null || v.isEmpty()) ? def : v;
    }
 
    public static Connection getConn() {
        if (conn == null) {
            synchronized (DBConnect.class) {
                if (conn == null) {
                    try {
                        // MySQL 8+ driver
                        Class.forName("com.mysql.cj.jdbc.Driver");
 
                        final String host = getenv("DB_HOST", "10.0.1.102");
                        final String port = getenv("DB_PORT", "3306");
                        final String name = getenv("DB_NAME", "ecomdb");
                        final String user = getenv("DB_USER", "ecomuser");
                        final String pass = getenv("DB_PASS", "ecomPass123!");
 
                        final String url =
                                "jdbc:mysql://" + host + ":" + port + "/" + name
                                        + "?useSSL=false"
                                        + "&allowPublicKeyRetrieval=true"
                                        + "&serverTimezone=UTC"
                                        + "&useUnicode=true"
                                        + "&characterEncoding=UTF-8";
 
                        Properties props = new Properties();
                        props.put("user", user);
                        props.put("password", pass);
 
                        conn = DriverManager.getConnection(url, props);
                    } catch (Exception e) {
                        // For quick visibility in Tomcat logs
                        e.printStackTrace();
                        throw new RuntimeException("Failed to create DB connection", e);
                    }
                }
            }
        }
        return conn;
    }
}
 
