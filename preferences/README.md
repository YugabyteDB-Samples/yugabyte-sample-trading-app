## Trading App / Preferences Module


## Get Started

1. Checkout

    ```bash
    git clone git@github.com:yugabyte/yugabyte-sample-trading-app.git
    ```

   *OR*

    ```bash
    git clone https://github.com/yugabyte/yugabyte-sample-trading-app.git
    ```

2. Change to `preferences` directory

    ```bash
    cd yugabyte-sample-trading-app/prefrences
    ```

3. **Temp** Install `testcontainer-yugabyte-1.0.0-beta-4.jar`

    ```bash
    ./mvnw install:install-file -Dfile=testcontainers-yugabytedb-1.0.0-beta-4.jar -DgroupId=com.yugabyte -DartifactId=testcontainers-yugabytedb -Dversion=1.0.0-beta-4 -Dpackaging=jar
    ```

4. Clean out any unwanted files
    ```bash
    ./mvnw clean
    ```
5. Run App

    ```bash
    ./mvnw spring-boot:run -Dspring-boot.run.profiles=ysql
    ```

6. Package as JAR

    ```bash
    ./mvnw clean install
    ```

7. Package as a docker container

    ```bash
    ./mvnw spring-boot:build-image
    ```
