# Perion-API-Test-1
Pull notification test script.

# Prerequisite

* Pelion Account
* A device which runs firmware provided by [Quick Start](https://cloud.mbed.com/quick-start). Get device id (endpoint name).
* tcsh

Replace the value of `apiKey` and `deviceId` in `pull-notification.sh`.

# Run

Run the script on your terminal.

### Sample Output

Sample output. The button on the board was pushed twice between 09:43:22 and 09:43:29.

```
$ ./pull-notification.sh
09:42:58 btnCnt=7
09:43:07 btnCnt=7
09:43:14 btnCnt=7
09:43:22 btnCnt=7
09:43:29 btnCnt=8  (cached)
09:43:35 btnCnt=8  (cached)
09:43:42 btnCnt=8  (cached)
09:43:48 btnCnt=8  (cached)
09:43:55 btnCnt=8  (cached)
09:44:01 btnCnt=8  (cached)
09:44:09 btnCnt=8  (cached)
09:44:15 btnCnt=8  (cached)
09:44:21 btnCnt=8  (cached)
09:44:28 btnCnt=8
09:44:35^C
```
