using System.Collections.Generic;
using UnityEngine;

namespace Trismegistus.Navigation.Iterator
{
    public interface INavigationIterator : IEnumerator<Vector3>
    {
        float StoppingDistance { get; }
        Event DestinationChanged { get; }
        Vector3 Destination { get; }
        void SetStoppingDistance(float distance);
    }
}