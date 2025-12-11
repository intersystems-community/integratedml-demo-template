# TensorFlow 2.16.1 with Jupyter - updated December 2025
FROM tensorflow/tensorflow:2.16.1-jupyter
LABEL maintainer="Thomas Dyar <Thomas.Dyar@intersystems.com>"

COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Start Jupyter notebook server
CMD ["jupyter", "notebook", "--notebook-dir=/tf", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''"]