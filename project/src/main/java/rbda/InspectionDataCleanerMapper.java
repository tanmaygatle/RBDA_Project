package rbda;

import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;

import java.io.IOException;

public class InspectionDataCleanerMapper extends Mapper<LongWritable, Text, LongWritable, Text> 
{
    @Override
    public void map(LongWritable key, Text value, Context context) 
        throws IOException, InterruptedException {
        /*
        * Mapper task to clean the NYC_Inspection.csv
        */

        String line = value.toString();
        StringBuilder result = new StringBuilder(line);
        /*
        * Change the comma seperated lines to '|' seperated.
        * Required as some fields themselves contain ','
        */
        boolean change = true;
        for(int i=0; i<result.length(); i++) {
            if(result.charAt(i) == '"') {
                change = !change;
            }
            if(change && result.charAt(i)==',') {
                result.setCharAt(i, '=');
            }
        }
        context.write(key, new Text(result.toString()));
    }
}
