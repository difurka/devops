# EN

A bash script was written. The script outputs the following information:

HOSTNAME = network name</br>
TIMEZONE = time zone as: America/New_York UTC -5 (time zone must be taken from the system and be correct for the current location)</br>
USER = current user who ran the script</br>
OS = type and version of operating system</br>
DATE = current time as: 12 May 2020 12:24:36</br>
UPTIME = system uptime</br>
UPTIME_SEC = system uptime in seconds</br>
IP = _ip address of the machine on any of the network interfaces</br>
MASK = network mask of any of the network interfaces as: xxx.xxx.xxx.xxx.</br>
GATEWAY = default gateway ip</br>
RAM_TOTAL = main memory size in GB with an accuracy of three decimal places as: 3.125 GB</br>
RAM_USED = used memory size in GB with an accuracy of three decimal places</br>
RAM_FREE = free memory size in GB, with an accuracy of three decimal places</br>
SPACE_ROOT = root partition size in MB, with an accuracy of two decimal places, as 254.25 MB</br>
SPACE_ROOT_USED = size of used space of the root partition in MB, with an accuracy of two decimal places</br>
SPACE_ROOT_FREE = size of free space of the root partition in MB, with an accuracy of two decimal places

After outputting the values, suggest writing the data to a file (the user is asked to answer Y/N).
Responses Y and y are considered positive, all others - negative.
If the user agrees, a file is created in the current directory containing the information that had been outputted.
The file name looks like: DD_MM_YY_HH_MM_SS.status (The time in the file name indicates when the data was saved).

---

# RU

Написан bash-скрипт. Скрипт выводит на экран информацию в виде:

HOSTNAME = сетевое имя</br>
TIMEZONE = временная зона в виде: America/New_York UTC -5 (временная зона, должна браться из системы и быть корректной для текущего местоположения)</br>
USER = текущий пользователь который запустил скрипт</br>
OS = тип и версия операционной системы</br>
DATE = текущее время в виде: 12 May 2020 12:24:36</br>
UPTIME = время работы системы</br>
UPTIME_SEC = время работы системы в секундах</br>
IP = ip-адрес машины в любом из сетевых интерфейсов</br>
MASK = сетевая маска любого из сетевых интерфейсов в виде: xxx.xxx.xxx.xxx</br>
GATEWAY = ip шлюза по умолчанию</br>
RAM_TOTAL = размер оперативной памяти в Гб c точностью три знака после запятой в виде: 3.125 GB</br>
RAM_USED = размер используемой памяти в Гб c точностью три знака после запятой</br>
RAM_FREE = размер свободной памяти в Гб c точностью три знака после запятой</br>
SPACE_ROOT = размер рутового раздела в Mб с точностью два знака после запятой в виде: 254.25 MB</br>
SPACE_ROOT_USED = размер занятого пространства рутового раздела в Mб с точностью два знака после запятой</br>
SPACE_ROOT_FREE = размер свободного пространства рутового раздела в Mб с точностью два знака после запятой</br>

После вывода значений предлогается записать данные в файл (пользователю предлогается ответить Y/N).
Ответы Y и y считаются положительными, все прочие - отрицательными.
При согласии пользователя, в текущей директории создаётся файл содержащий информацию, которая была выведена на экран.
Название файла имеет вид: DD_MM_YY_HH_MM_SS.status (Время в имени файла указывает момент сохранения данных).
