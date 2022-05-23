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
    ./mvnw install:install-file -Dfile=./lib/testcontainers-yugabytedb-1.0.0-beta-4.jar -DgroupId=com.yugabyte -DartifactId=testcontainers-yugabytedb -Dversion=1.0.0-beta-4 -Dpackaging=jar
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

8. Frontend development

   ```bash
   cd src/main/frontend
   npm run start
   ```

## Links

| Link                                | Description                                                                         |
|-------------------------------------|-------------------------------------------------------------------------------------|
| http://localhost:8080               | Bundled UI - Only updated on restarting Java App                                    |
| http://localhost:3000               | Live Development UI - Make change in the JS file and you will see the changes here  |
| http://localhost:8080/actuator      | Monitoring URL root                                                                 |
| http://localhost:8080/api-docs      | Open API v3.0 Spec ( JSON )                                                         |
| http://localhost:8080/api-docs.yaml | Open API v3.0 Spec ( YAML )                                                         |
| http://localhost:8080/api-docs.html | Open API / Swagger UI                                                               |


## Screenshots

1. Main UI (Desktop)

    ![Main Desktop UI](docs/main-ui-desktop.png)

2. Main UI (Mobile)

    ![Main Mobile UI](docs/main-ui-mobile.png)
