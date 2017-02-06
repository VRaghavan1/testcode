# Setting up the Data Preparation Server


```bash
export DATA_PROCESSING_RUNTIME=/app/data-processing-runtime

export DATA_PROCESSING_FOUNDATION=/app/foundation-task-runner-project

export DATA_PROCESSING_FOUNDATION_TASK_FOLDER=$DATA_PROCESSING_FOUNDATION/tasks
export DATA_PROCESSING_FOUNDATION_SETTINGS_FILE=$DATA_PROCESSING_FOUNDATION/tasks/settings.json
export DATA_PROCESSING_FOUNDATION_ENDECA_OUTPUT_FILE=$DATA_PROCESSING_FOUNDATION/output/foundation-endeca-records.xml

export DATA_PROCESSING_FOUNDATION_ATG_PROCESSING_FOLDER=/tmp/atg/endeca-export

export DATA_PROCESSING_FOUNDATION_DATA=/tmp/data
```


```bash
sudo mkdir -p /app/data-processing-runtime
sudo chown -R endeca:users2 /app/data-processing-runtime
tar xvf data-processing-runtime.tar.gz -C /app/data-processing-runtime


node --max_old_space_size=8192 $DATA_PROCESSING_RUNTIME/task-runner.js -f $DATA_PROCESSING_FOUNDATION -s tasks/foundation-test-settings.json -c 4 -p FOUNDATION_DATA=$DATA_PROCESSING_FOUNDATION_DATA -l tasks/foundation-tasks.json -d tasks/task-dependencies.json -m -v | ./node_modules/.bin/bunyan -l error

```


Notes:
* 4 cores took 25 mins
* 8 cores took 17 mins
* 16 cores took 16 mins
