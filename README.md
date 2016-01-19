#Project Description
To demonstrate unexpected behaviour of heka pipeline; giving output in different order than the input. 

#How to replicate the error
1. Change global variables in conf/heka.toml accordingly.
2. Copy the demo.log from testlog/demo.log to relevant folder.
3. Change the output file location to a desired location by changing line number 7 of lua/demo-output.lua 
4. Start the hekad using command line ./hekad --config ../conf/heka.toml
5. Check the output in events_buffer.log. (output file)
6. Clean the base_dir and restart pipeline.
7. Repeat step 4-6 till erroneous output. (Usually appears in first 10 attempts.)

#Outputs

##Expected output
{"event":{"date":"2015-01-04","telephone":"111222333"},"_id":{"consumer":"CUS_00001"}}
{"event":{"date":"2015-01-04","telephone":"333444555"},"_id":{"consumer":"CUS_00002"}}

##Errorneous output
{"event":{"date":"2015-01-04","telephone":"333444555"},"_id":{"consumer":"CUS_00002"}}
{"event":{"date":"2015-01-04","telephone":"111222333"},"_id":{"consumer":"CUS_00001"}}