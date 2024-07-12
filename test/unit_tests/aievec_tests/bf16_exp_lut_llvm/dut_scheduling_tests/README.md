The tests in this folder include a variety of iterative changes to the dut.cc code to try and get
better performance through the peano compiler. Most notably, manually software pipelining the loop
gives ~800 cycle or ~40% fewer cycle performance improvement when the loop is unrolled. 

After running the tests, you can run 
```
grep -R -T "TITLE" --include="testsummary.txt"
```
to get a quick listing of the cycle count and changes for each test. If you want a more detailed look
at what's different in each test, you can look at the testdoc.txt in each of the test folders.
