from configparser import ConfigParser


def config(filename='database.ini', section='postgresql'):
    # create a parser
    parser = ConfigParser()
    # read config file
    parser.read(filename)

    # get section, default to postgresql
    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        # retorna llista de tuples
        # print(params)
        for param in params:
            db[param[0]] = param[1]
            #print('param \t ', param)
    else:
        raise Exception(
            'Section {0} not found in the {1} file'.format(section, filename))

    # retorna diccionari
    # print(db)
    # print(type(db))
    return db


"""
if __name__ == '__main__':
    config()
"""
