<!--
---
title: "SQL Server Python Tutorials | Microsoft Docs"
ms.custom: 
  - "SQL2016_New_Updated"
ms.date: "06/28/2017"
ms.prod: "sql-server-2017"
ms.reviewer: ""
ms.suite: ""
ms.technology: 
  - "r-services"
ms.tgt_pltfrm: ""
ms.topic: "article"
applies_to: 
  - "SQL Server 2017"
dev_langs: 
  - "Python"
caps.latest.revision: 1
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
-->

# SQL Server + Python �`���[�g���A��

���̋L����Python��SQL Server 2017�Ŏg�p���邽�߂̃`���[�g���A���ƃT���v����񋟂��܂��B����ɂ���Ď��̂��Ƃ��w�т܂��B

+ T-SQL����Python�����s������@
+ �����[�g����у��[�J���̌v�Z�R���e�L�X�g�̗����A�����SQL Server���g�p����Python�R�[�h�����s������@
+ Python�R�[�h���X�g�A�h�v���V�[�W���Ƃ��Ē�`������@
+ �{�Ԋ��p��Python�R�[�h�̍œK��
+ �A�v���P�[�V�����ɋ@�B�w�K��g�ݍ��ނ��߂̌����ɑ������V�i���I

�v���ƃZ�b�g�A�b�v�̏ڍׂɂ��ẮA[�O�����](#bkmk_Prerequisites)���Q�Ƃ��Ă��������B

## <a name="bkmk_pythontutorials"></a>Python �`���[�g���A��

+ [T-SQL����Python�����s������@](run-python-using-t-sql.md)

  SQL Server 2016���瓱�����ꂽ�g���@�\���g����T-SQL����Python�����s���邽�߂̊�b���w�т܂��B

+ [revoscalepy���g����Python�ŋ@�B�w�K���f�����쐬����](use-python-revoscalepy-to-create-model.md)

  �V���� **revoscalepy** ���C�u������ **rxLinMod** ���g�p���ă��f�����쐬���܂��B�R�[�h�̓����[�g��Python�^�[�~�i������N������܂����A���f�����O��SQL Server�̃R���e�L�X�g�ŏ�������܂��B

+ [Python�ŗ\�����f���\�z����](https://github.com/gho9o9/sql-server-samples/tree/master/samples/features/machine-learning-services/python/getting-started/rental-prediction)

  �X�g�A�h�v���V�[�W�����g�p���ăX�L�[�����^�����Ƃ̓��X�̎��v�\�����s�����f�����쐬���܂��B

+ [SQL�J���҂̂��߂� In-Database Python ����](sqldev-in-database-python-for-sql-developers.md)

  T-SQL�X�g�A�h�v���V�[�W�����g�p���Ċ��S��Python�\�����[�V�������\�z���܂��B

+ [Python���f���̓W�J�Ɨ��p](..\python\publish-consume-python-code.md)

  Microsoft Machine Learning Server�̍ŐV�o�[�W�������g�p����Python���f���𓱓�������@���w�т܂��B

<!--
## Python�T���v��

These samples and demos provided by the SQL Server development team highlight ways that you can use embedded analytics in real-world applications.

+ [Build a predictive model using Python and SQL Server](https://microsoft.github.io/sql-ml-tutorials/python/rentalprediction/)

  Learn how a ski rental business might use machine learning to predict future rentals, which helps the business plan and staff to meet future demand.
-->

## <a name="bkmk_Prerequisites"></a>�O�����

�����̃`���[�g���A�����g�p����ɂ́ASQL Server 2017 Machine Learning Services (In-Database)���C���X�g�[������Ă���K�v������܂��BMachine Learning Services��R�܂���Python���T�|�[�g���Ă��܂��B�������APython�𗘗p����ۂɂ̓C���X�g�[�����錾���Python��I������K�v������܂��B�Ȃ�R��Python�̗����𓯂��R���s���[�^�ɃC���X�g�[�����邱�Ƃ��\�ł��B

<!--
> [!NOTE]
>
> Support for Python is a new feature in SQL Server 2017 (CTP 2.0). Although the feature is in pre-release and not supported for production environments, we invite you to try it out and send feedback.
**SQL Server 2017**
-->

SQL Server�̃C���X�g�[��������ɁA�ȉ��̃X�e�b�v���K�v�ł��B

+ �O���X�N���v�g���s�@�\��L�������܂��B `sp_configure 'enable external script', 1`
+ SQL Server���ċN�����܂��B
+ �O�������^�C���̃R�[���ɕK�v�Ȍ������T�[�r�X�A�J�E���g�ɕt�^����Ă��邱�Ƃ��m�F���܂��B
+ �T�[�o�[�ւ̐ڑ��A�f�[�^�̓ǂݎ��A����уT���v���ɕK�v�ȃf�[�^�x�[�X�I�u�W�F�N�g�̍쐬�ɕK�v�ȃA�N�Z�X����SQL���O�C���܂���Windows���[�U�[�A�J�E���g�ɕt�^����Ă��邱�Ƃ��m�F���܂��B

�g���u���ɑ��������ꍇ�́A���̈�ʓI�Ȗ��ɂ��Ă̋L�����Q�l�ɂ��Ă��������B[SQL Server R Services�̃C���X�g�[���ƃA�b�v�O���[�h](../../advanced-analytics/r-services/upgrade-and-installation-faq-sql-server-r-services.md)

## �֘A����

[R �`���[�g���A��](sql-server-r-tutorials.md)


<!--
---
title: "SQL Server Python Tutorials | Microsoft Docs"
ms.custom: 
  - "SQL2016_New_Updated"
ms.date: "06/28/2017"
ms.prod: "sql-server-2017"
ms.reviewer: ""
ms.suite: ""
ms.technology: 
  - "r-services"
ms.tgt_pltfrm: ""
ms.topic: "article"
applies_to: 
  - "SQL Server 2017"
dev_langs: 
  - "Python"
caps.latest.revision: 1
author: "jeannt"
ms.author: "jeannt"
manager: "jhubbard"
---
# SQL Server Python Tutorials

This article provides a list of tutorials and samples that demonstrate the use of Python with SQL Server 2017. Through these samples and demos, you will learn:

+ How to run Python from T-SQL
+ What are remote and local compute contexts, and how you can execute Python code using the SQL Server computer
+ How to wrap Python code in a stored procedure
+ Optimizing Python code for a SQL production environment
+ Real-world scenarios for embedding machine learning in applications

For information about requirements and setup, see [Prerequisites](#bkmk_Prerequisites).

## <a name="bkmk_pythontutorials"></a>Python Tutorials

+ [Running Python in T-SQL](run-python-using-t-sql.md)

   Learn the basics of how to call Python in T-SQL, using the extensibility mechanism pioneered in SQL Server 2016.

+ [Create a Machine Learning Model in Python using revoscalepy](use-python-revoscalepy-to-create-model.md)

   You'll create a model using **rxLinMod**, from the new **revoscalepy** library. You'll launch the code from a remote Python terminal but the modeling will take place in the SQL Server compute context.

+ [Build a predictive model with Python (GitHub)](https://github.com/Microsoft/sql-server-samples/tree/master/samples/features/machine-learning-services/python/getting-started/rental-prediction)

  Create a machine learning model to predict demand for a ski rental business, and operationalize that model for day-to-day demand prediction using stored procedures. All code and data is provided.

+ [In-Database Python Analytics for SQL Developers](sqldev-in-database-python-for-sql-developers.md)

  NEW! Build a complete Python solution using T-SQL stored procedures. All Python code is included.

+ [Deploy and Consume a Python Model](..\python\publish-consume-python-code.md)

  Learn how to deploy a Python model using the latest version of Microsoft Machine Learning Server.

## Python Samples

These samples and demos provided by the SQL Server development team highlight ways that you can use embedded analytics in real-world applications.

+ [Build a predictive model using Python and SQL Server](https://microsoft.github.io/sql-ml-tutorials/python/rentalprediction/)

  Learn how a ski rental business might use machine learning to predict future rentals, which helps the business plan and staff to meet future demand.

## <a name="bkmk_Prerequisites"></a>Prerequisites

To use these tutorials, you must have installed SQL Server 2017 Machine Learning Services (In-Database). SQL Server 2017 supports either R or Python. However, you must install the extensibility framework that supports machine learning, and select Python as the language to install. You can install both R and Python on the same computer.

> [!NOTE]
>
> Support for Python is a new feature in SQL Server 2017 (CTP 2.0). Although the feature is in pre-release and not supported for production environments, we invite you to try it out and send feedback.
**SQL Server 2017**

After running SQL Server setup, don't forget these important steps:

+ Enable the external script execution feature by running `sp_configure 'enable external script', 1`
+ Restart the server
+ Ensure that the service that calls the external runtime has necessary permissions
+ Ensure that your SQL login or Windows user account has necessary permissions to connect to the server, to read data, and to create any database objects required by the sample

If you run into trouble, see this article for some common issues: [Upgrade and Installation of SQL Server R Services](../../advanced-analytics/r-services/upgrade-and-installation-faq-sql-server-r-services.md)

## See Also

[R Tutorials](sql-server-r-tutorials.md)
-->