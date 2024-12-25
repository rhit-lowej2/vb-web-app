FROM mcr.microsoft.com/mssql/server:2019-latest

RUN whoami
USER root
# Install the SQL Server tools
RUN apt-get update && apt-get install -y gnupg

RUN apt-get update && apt-get install -y curl apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && apt-get clean

# Set environment variables
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=funky-penguin-cafe-train8
ENV MSSQL_PID=Express

# Expose the SQL Server port
EXPOSE 1433

# Run SQL Server process
CMD ["/opt/mssql/bin/sqlservr"]
