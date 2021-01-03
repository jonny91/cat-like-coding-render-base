//=========================================
//Author: 洪金敏
//Email: jonny.hong91@gmail.com
//Create Date: 2021/01/02 23:25:04
//Description: 
//=========================================

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TransformGrid : MonoBehaviour
{
	public Transform Prefab;
	public int GridResolution = 10;

	private Transform[] _grid;

	private List<Transformation> _transformations;

	public Matrix4x4 Transformation;

	private void Awake()
	{
		_grid = new Transform[GridResolution * GridResolution * GridResolution];

		for (int i = 0, z = 0; z < GridResolution; z++)
		{
			for (int y = 0; y < GridResolution; y++)
			{
				for (int x = 0; x < GridResolution; x++, i++)
				{
					_grid[i] = CreateGridPoint(x, y, z);
				}
			}
		}

		_transformations = new List<Transformation>();
	}

	private void Update()
	{
		UpdateTransfomation();

		for (int i = 0, z = 0; z < GridResolution; z++)
		{
			for (int y = 0; y < GridResolution; y++)
			{
				for (int x = 0; x < GridResolution; x++, i++)
				{
					_grid[i].localPosition = TransformPoint(x, y, z);
				}
			}
		}
	}

	private void UpdateTransfomation()
	{
		GetComponents<Transformation>(_transformations);
		if (_transformations.Count > 0)
		{
			Transformation = _transformations[0].Matrix;
			for (int i = 0; i < _transformations.Count; i++)
			{
				Transformation = _transformations[i].Matrix * Transformation;
			}
		}
	}

	private Vector3 TransformPoint(int x, int y, int z)
	{
		var coordinates = GetCoordinates(x, y, z);
		return Transformation.MultiplyPoint(coordinates);
	}

	private Transform CreateGridPoint(int x, int y, int z)
	{
		var point = Instantiate<Transform>(Prefab);
		point.localPosition = GetCoordinates(x, y, z);
		point.GetComponent<MeshRenderer>().material.color = new Color(
			(float) x / GridResolution,
			(float) y / GridResolution,
			(float) z / GridResolution
		);
		return point;
	}

	private Vector3 GetCoordinates(int x, int y, int z)
	{
		return new Vector3(
			x - (GridResolution - 1) * 0.5f,
			y - (GridResolution - 1) * 0.5f,
			z - (GridResolution - 1) * 0.5f
		);
	}
}