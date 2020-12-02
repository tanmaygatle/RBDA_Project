package rbda;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class InspectionDataCleanerReducer extends Reducer<LongWritable, Text, NullWritable, Text> {

    @Override
    public void reduce(LongWritable key, Iterable<Text> values, Context context)
            throws IOException, InterruptedException {
         /*
        * Reducer to clean NYC_Inspection data
        * Writes only the value 
        */
        for(Text value : values) {
            context.write(NullWritable.get(), value);
        }
    }
}
