#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request, redirect, url_for

import psycopg2
import psycopg2.extras


# SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist19330"
DB_DATABASE=DB_USER
DB_PASSWORD="usgg9929"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)

app = Flask(__name__)

@app.route('/categories')
def list_categories():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT nome FROM categoria;"
        cursor.execute(query)
        return render_template("categories.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


@app.route('/add_category')
def add_category():
    try:
        return render_template("add_category.html", params=request.args)
    except Exception as e:
        return str(e)

@app.route('/categories/add') 
def execute_add_category():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "INSERT INTO categoria VALUES (%s);"
        data = (request.form["nome"])
        cursor.execute(query,data)
        return redirect(url_for('list_categories', nome=request.form["nome"])) 
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route('/categories/remove') 
def execute_remove_category():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query1 = "DELETE FROM evento_reposicao WHERE ean IN (SELECT ean FROM planograma,produto.planograma.cat = %s)"
        query2 = "DELETE FROM responsavel_por WHERE nome_cat = %s"
        query3 = "DELETE FROM planograma WHERE nome IN (SELECT nro FROM prateleira WHERE nome = %s NATURAL JOIN (SELECT nro FROM planogram WHERE nro = prateleira.nro))"
        query4= "DELETE FROM prateleira WHERE nome = %s"
        query5= "DELETE FROM tem_categoria WHERE nome = %s"
        query6= "DELETE FROM produto WHERE cat = %s"
        query7= "DELETE FROM tem_outra WHERE super_categoria = %s OR categoria = %s"
        query8= "DELETE FROM super_categoria WHERE nome = %s"
        query9= "DELETE FROM categoria_simples WHERE nome = %s"
        query10= "DELETE FROM categoria WHERE nome = %s;" 
        query=query1+query2+query3+query4+query5+query6+query7+query8+query9+query10
        data = (request.args.get('nome')) #DATA VEM DA QUERIE
        cursor.execute(query,data)
        return redirect(url_for('list_categories', nome=request.args.get["nome"]))
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


@app.route('/retailer') 
def list_retailer():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT tin,name_ FROM retalhista;" 
        cursor.execute(query)
        return render_template("retailers.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route('/add_retailer')
def add_retailer():
    try:
        return render_template("add_retailer.html", params=request.args)
    except Exception as e:
        return str(e)


@app.route('/retailer/add')
def execute_add_retailer():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "INSERT INTO retalhista VALUES (%s);"
        nome = (request.form["nome"])
        data=(nome) 
        cursor.execute(query,data)
        return redirect(url_for('list_retailer', nome=request.form["nome"])) 
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route('/retailer/remove') 
def execute_remove_retailer():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "DELETE FROM evento_reposicao WHERE tin = %s DELETE FROM responsavel_por WHERE tin = %s DELETE FROM retalhista WHERE tin = %s;" 
        tin = (request.args.get('tin')) #DATA VEM DA QUERIE
        data=(tin) 
        cursor.execute(query,data)
        return redirect(url_for('list_retailer', nome=request.args.get["tin"]))
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()



@app.route('/listEvents') 
def listEvents():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT cat, SUM(unidades) AS total FROM evento_reposicao NATURAL JOIN (SELECT ean,cat FROM produto WHERE cat = %s)WHERE num_serie= %s GROUP BY cat;" #CORRIGIR
        cat=(request.args.get('cat'))
        serial_number=(request.args.get('num_serie'))
        data=(cat,serial_number)
        cursor.execute(query,data)
        return render_template("listEvents.html", cursor=cursor, params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route('/listCategoriesFromSuper')
def list_Category_From_Super():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT categoria FROM tem_outra WHERE tem_outra.super_categoria = %s;" 
        data = request.args.get('categoria') 
        cursor.execute(query,data)
        return render_template("listCategoriesFromSuper.html", cursor=cursor,params=request.args)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


CGIHandler().run(app)