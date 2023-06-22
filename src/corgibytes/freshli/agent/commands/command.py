import abc

class Command:
    @abc.abstractmethod
    def execute(self):
        raise NotImplementedError()
