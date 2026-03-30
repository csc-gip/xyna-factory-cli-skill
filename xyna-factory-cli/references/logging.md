# Log Files and Logging Configuration

## Finding the Log Files

The **Log4j2** configuration is located at:

```bash
$XYNA_DIR/server/log4j2.xml
```

Inspect this file to determine where log files are written:
1. find the Root logger
2. find the used appender
3. follow appender references, when neccessary

Example:

```bash
$ grep -A5 "<Root " ${XYNA_DIR}/server/log4j2.xml 
    <Root level="debug">
      <AppenderRef ref="ASYNC" />
    </Root>

    <!-- utils debugoutput -->
    <Logger name="xyna.utils" level="error"/>

$ grep -A2 ASYNC ${XYNA_DIR}/server/log4j2.xml
    <XynaAsync name="ASYNC" blocking="true", queueSize="10000" discardedMessageThreshold="32" maxEventRate="0"> -->
    <XynaAsync name="ASYNC">
      <AppenderRef ref="SYSLOG"/>
    </XynaAsync>
--
      <AppenderRef ref="ASYNC" />
    </Root>

$ grep -A2 SYSLOG ${XYNA_DIR}/server/log4j2.xml
    <XynaSyslog name="SYSLOG" host="localhost" facility="local0" charset="UTF-8">
      <!-- http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/PatternLayout.html: %C, %M, %L are extremely slow -->
      <PatternLayout pattern="XYNA_001 %-5p [%t] (%C:%M:%L) - %x %m%n"/>
--
    <XynaSyslog name="SYSLOGNoContext" host="localhost" facility="local0" charset="UTF-8">
      <PatternLayout pattern="XYNA_001 %-5p (%C:%M:%L) - %m%n"/>
    </XynaSyslog>
--
      <AppenderRef ref="SYSLOG"/>
    </XynaAsync>
  </Appenders>

```

## Inspecting configured loggers

List explicitly configured loggers:

```bash
$XYNA listlogger
```

List known loggers:

```bash
$XYNA listlogger -v
```

## Changing Logger Configuration

Change the logging without restarting Xyna Factory:

Examples:

Change and then reload log4j2.xml:

```bash
$XYNA loadlogproperties
```

Use a different file:

```bash
$XYNA loadlogproperties -filename log4j2_new.xml
```

Temporary change:

```bash
$XYNA setloglevel -level DEBUG -logger com.gip.xyna.utils.db
```

Levels:

```
TRACE
DEBUG
INFO
WARN
ERROR
```