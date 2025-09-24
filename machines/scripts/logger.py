import logging

class ColorFormatter(logging.Formatter):
    COLORS = {
        'INFO': '\033[92m',    # 绿色
        'WARNING': '\033[93m', # 黄色
        'ERROR': '\033[91m',   # 红色
        'DEBUG': '\033[94m',   # 蓝色
        'ENDC': '\033[0m',     # 结束
    }
    def format(self, record):
        color = self.COLORS.get(record.levelname, '')
        endc = self.COLORS['ENDC']
        message = super().format(record)
        return f"{color}{message}{endc}"

def setup_logger():
    logger = logging.getLogger("config_logger")
    logger.setLevel(logging.INFO)
    handler = logging.StreamHandler()
    formatter = ColorFormatter('%(levelname)s: %(message)s')
    handler.setFormatter(formatter)
    logger.handlers = []
    logger.addHandler(handler)
    return logger

logger = setup_logger()

def log_message(msg, level="info"):
    if level == "info":
        logger.info(msg)
    elif level == "warning":
        logger.warning(msg)
    elif level == "error":
        logger.error(msg)
    elif level == "debug":
        logger.debug(msg)