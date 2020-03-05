# minikube
Run minikube on Centos/7 VM

## Descripción

Máquina virtual que ejecuta **minikube** en ambiente local linux Centos/7

## Requerimientos
 - Software requerido:
   - VirtualBox x64 link: https://www.virtualbox.org/wiki/Downloads
   - Vagrant link: https://www.vagrantup.com/downloads.html
 - Hardware requerido:
   - 4 GB+ memoria RAM mínimi para máquina virtual
   - 2 CPU mínimo para máquina virtual
   - 40 GB espacio en disco disponible

## Instrucciones

- Descargar el repositorio minikube:
  - git clone https://github.com/jontambi/minikube.git
  
- Ubicarse en $Downloaded_Directory/minikube:
  - cd $Downloaded_Directory/minikube

- Iniciar máquina virtual
  - vagrant up

- Iniciar minikube:
  - Ingresar a la máquina virtual
    - vagrant ssh
  
  - Iniciar minikube:
    - sudo minikube --vm-driver=none
  
  - Verificar estado:
    - sudo minikube status
    
*Ahora tendrás ejecutandose un servidor de minikube para el despliegue de contenedores y servicios en tu ambiente local.*
