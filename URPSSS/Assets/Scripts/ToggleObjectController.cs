using UnityEngine;

public class ToggleObjectController : MonoBehaviour
{
    public GameObject[] targetObjects; // 所有需要控制的物体
    public int defaultIndex = 0;       // 默认显示的物体索引

    void Start()
    {
        // 初始化：只显示默认物体
        SetActiveObject(defaultIndex);
    }

    // 通过索引切换物体
    public void SetActiveObject(int index)
    {
        for (int i = 0; i < targetObjects.Length; i++)
        {
            targetObjects[i].SetActive(i == index);
        }
    }
}