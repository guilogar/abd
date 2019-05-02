
import java.sql.*;

public class connectToResources
{
    private Connection conexion = null;
    private Statement operacion = null;
    private ResultSet resultado = null;
    
    /**
     * 
     *
     */
    public void consulta() throws SQLException
    {
        resultado = operacion.executeQuery("select * from practicasabd.actas; ");
        imprimeResultado(resultado);
    }
    
    /**
     * Metodo para imprimir el resultado
     * @param resultado
     * @throws SQLException
     */
    private void imprimeResultado(ResultSet resultado) throws SQLException
    {
        while (resultado.next())
        {
            System.out.println("Nuevo elemento:");
            System.out.println("---------------");
            
            for (int i = 1; i < resultado.getMetaData().getColumnCount(); i++)
            {
                System.out.println(
                    "Resultado de la columna " + i + resultado.getMetaData().getColumnDisplaySize(i) +
                    ": " + resultado.getString(i)
                );
            }
        }
    }
    
    /**
     * Metodo para la apertura de la conexion con la base de datos
     *
     */
    public void apertura()
    {
        try
        {
            // Clase de la base de datos que voy a utilizar en la db
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Configuracion de base de datos en remoto desde java
            conexion = DriverManager.getConnection(
                "jdbc:mysql://localhost/"               +
                "practicasabd?user=root&password=root&" +
                "useUnicode=true&"                      +
                "useJDBCCompliantTimezoneShift=true&"   +
                "useLegacyDatetimeCode=false&"          +
                "serverTimezone=UTC"
            );
            
            // Apertura de la conexion a traves de un objeto statement
            operacion = conexion.createStatement();
            
        } catch(Exception e) { e.printStackTrace();}
    }
    
    
    /**
     * Metodo para el cierre de la conexion con la base de datos
     * @throws SQLException
     */
    public void cierre() throws SQLException
    {
        if(!conexion.isClosed())  { conexion.close(); }
        
        if(!operacion.isClosed()) { operacion.close(); }
        
        if(!resultado.isClosed()) { resultado.close(); }
    }
}
