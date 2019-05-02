import java.sql.*;

public class Main
{
    public static void main (String[] args) throws SQLException
    {
        connectToResources nuevaConexion = new connectToResources();
        
        nuevaConexion.apertura();
        nuevaConexion.consulta();
        nuevaConexion.cierre();
    }
}
